name: Build and Push Docker Image

on:
  push:
    branches:
      - main # veya istediğiniz dal
  pull_request: # İsteğe bağlı: çekme isteklerinde de çalıştırabilirsiniz
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v1

      - name: Login to GitHub Container Registry
        uses: docker/login-action@v1
        with:
          registry: ghcr.io
          username: ${{ github.repository_owner }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Build and push Docker image
        uses: docker/build-push-action@v2
        with:
          context: .
          push: true
          tags: ghcr.io/${{ github.repository_owner }}/${{ github.event.repository.name }}:${{ github.sha }}
          # veya tags: ghcr.io/${{ github.repository_owner }}/${{ github.event.repository.name }}:latest
