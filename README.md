# cap
My cap is not Capistrano, but a multi threaded ssh handler


## Usage

Usage: ./cap group|host command

  groups and hosts are defined in './config/nodes'

  command is launched on hosts belonging to the group

  default command is hostname


## Examples

Listing of hosts belonging to 'archives' group

```
./cap archives
2018-11-13 17:55:31 +0100
------------------------------------------
==> ssh pyer@archive1 hostname
==> ssh pyer@archive2 hostname
------------------------------------------
Elapsed time: 1.8 s   : :     
==========================================
==> ssh pyer@archive1 hostname   (Duration: 1.8 s)
archive1
==> ssh pyer@archive2 hostname   (Duration: 1.8 s)
archive2

```

Cleaning some files

```
./cap archives "rm /tmp/*.txt"
2018-11-13 18:01:56 +0100
------------------------------------------
==> ssh pyer@archive1 rm /tmp/*.txt
==> ssh pyer@archive2 rm /tmp/*.txt
------------------------------------------
Elapsed time: 1.8 s   : :     
==========================================
==> ssh pyer@archive1 rm /tmp/*.txt   (Duration: 1.7 s)
rm: cannot remove '/tmp/*.txt': No such file or directory
==> ssh pyer@archive2 rm /tmp/*.txt   (Duration: 1.8 s)

```


## Configuration

Hosts and groups are defined in './config/nodes'

SSH parameters are defined in '~/.ssh/config'
