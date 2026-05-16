from http.server import BaseHTTPRequestHandler, HTTPServer
import json

HOST = '127.0.0.1'
PORT = 8787

class Handler(BaseHTTPRequestHandler):
    def _send(self, status, payload):
        body = json.dumps(payload).encode('utf-8')
        self.send_response(status)
        self.send_header('Content-Type', 'application/json')
        self.send_header('Content-Length', str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def do_POST(self):
        if self.path != '/api/identity/verify':
            self._send(404, {'error': 'not found'})
            return

        length = int(self.headers.get('Content-Length', '0'))
        raw = self.rfile.read(length).decode('utf-8') if length else '{}'
        try:
            data = json.loads(raw)
        except json.JSONDecodeError:
            self._send(400, {'status': 'error', 'error': 'invalid json'})
            return

        full_name = (data.get('full_name') or '').strip().lower()
        id_number = (data.get('id_number') or '').strip()

        if full_name == 'joe black' and id_number == '123456':
            self._send(200, {'status': 'verified'})
        else:
            self._send(200, {'status': 'not_verified'})

    def log_message(self, format, *args):
        return

if __name__ == '__main__':
    server = HTTPServer((HOST, PORT), Handler)
    print(f'listening on http://{HOST}:{PORT}')
    server.serve_forever()
