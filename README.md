updates
=======

This is a updates script for Fedora and macOS.

## Running

```fish
make servers=servers.tsv run
```

### Data

Please provide a `servers.tsv` file with the following format:

```tsv
hostname	os	mac_address
```

Operating system can be `Fedora` or `macOS`.

For sample:

```tsv
macbookpro	macOS	56:cf:ee:6c:13:9b
imac	macOS	d6:5f:81:e8:fd:16
thinkpad	Fedora	36:1:91:ea:6c:b4
ideapad	Fedora	8e:d2:1:1c:70:19
```

Watch out for `arp` output as it eats leading zeroes.
