$cfg = parsejson( regsubst($::custom_config, '=>', ':', 'G' ) )

class { 'hdp':
	hostname => $cfg[hostname],
	domain   => $cfg[domain],
	aliases  => $cfg[aliases],
	letsencrypt => {
		install => $cfg[letsencrypt][install],
		domains => $cfg[letsencrypt][domains],
		email   => $cfg[letsencrypt][email],
	}
}