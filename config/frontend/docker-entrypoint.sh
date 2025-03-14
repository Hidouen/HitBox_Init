#!/bin/sh
set -e

echo "Starting frontend container..."
echo "Container is ready. You can now initialize your Vue project manually."
echo "Use 'docker exec -it hitbox_frontend sh' to access the container."

# Keep container running
tail -f /dev/null