# specify the VCL syntax version to use
vcl 4.1;

# import vmod_dynamic for better backend name resolution
import dynamic;

backend default {
  .host = "tileserv";
  .port = "7800";
}

# set up a dynamic director
# for more info, see https://github.com/nigoroll/libvmod-dynamic/blob/master/src/vmod_dynamic.vcc
sub vcl_init {
  new d = dynamic.director(port = "6081");
}

sub vcl_recv {
	# force the host header to match the backend (not all backends need it,
	# but example.com does)
	set req.http.host = "tile.whalesafe.com";
	# set the backend
	set req.backend_hint = d.backend("tile.whalesafe.com");
}
