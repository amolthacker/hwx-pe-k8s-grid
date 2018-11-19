FROM amolthacker/mockcompute-base
LABEL maintainer="amolthacker@gmail.com"

# Paths
ENV COMPUTE_BASE /hwx-pe/compute/

# Copy lib and scripts
RUN mkdir -p $COMPUTE_BASE
ADD src/compute-engine/. $COMPUTE_BASE
RUN chmod +x $COMPUTE_BASE/compute.sh
RUN cp $COMPUTE_BASE/compute.sh /usr/local/bin/.
RUN cp $COMPUTE_BASE/mockvalengine-0.1.0.jar /usr/local/lib/.

# Start Engine
ENTRYPOINT go run $COMPUTE_BASE/valengine.go

# Ports : 6000 (RPC) | 8000 (HTTP-Health)
EXPOSE 6000 8000