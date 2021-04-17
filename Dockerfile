FROM ledermann/rails-base-builder:3.0.1-alpine AS Builder

# Remove some files not needed in resulting image.
# Because they are required for building the image, they can't be added to .dockerignore
RUN rm -r package.json yarn.lock postcss.config.js babel.config.js tailwind.config.js

FROM ledermann/rails-base-final:3.0.1-alpine
LABEL maintainer="georg@ledermann.dev"

# Workaround to trigger Builder's ONBUILDs to finish:
COPY --from=Builder /etc/alpine-release /tmp/dummy

USER app

# Start up
CMD ["docker/startup.sh"]