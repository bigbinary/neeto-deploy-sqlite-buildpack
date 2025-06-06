FROM gcr.io/paketo-buildpacks/builder:base as builder

# Copy buildpack files
COPY . /buildpack

# Set permissions
RUN chmod +x /buildpack/bin/*

# Use the official CNB buildpack base image
FROM gcr.io/paketo-buildpacks/buildpack-base:latest

COPY --from=builder /buildpack /cnb/buildpacks/neeto-deploy/sqlite/0.1.0

ENV CNB_USER_ID=1000
ENV CNB_GROUP_ID=1000

LABEL \
  io.buildpacks.id="neeto-deploy/sqlite" \
  io.buildpacks.version="0.1.0" \
  org.opencontainers.image.source="https://github.com/bigbinary/neeto-deploy-sqlite-buildpack" \
  org.opencontainers.image.authors="NeetoDeploy Team <support@neeto.com>"

WORKDIR /cnb/buildpacks/neeto-deploy/sqlite/0.1.0
