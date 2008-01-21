Message-ID: <4794DDF7.9070009@domain.hid>
Date: Mon, 21 Jan 2008 19:01:27 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Patch selection by prepare-kernel.sh (again)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai-core@domain.hid

Philippe,

what was the idea behind commit #3256 [1]? It breaks the original
behavior of selection adeos-ipipe-2.6.23-... in the presence of 2.6.23.x
- and leaves a bad first impression for beginners (I received such a
notice here...). Was this for the special case
adeos-ipipe-2.6.20.21-i386-1.12-02.patch? But I think the common case
should take precedence over this corner case here. Unless there are more
issues with the original version, I would vote for restoring it.

Alternatively, we could add a safety belt by trying to apply the patch
with --dry-run first and only continue if this works out without
failures. Can hack this up if it's acceptable.

Jan

[1]http://svn.gna.org/viewcvs/xenomai/trunk/scripts/prepare-kernel.sh?rev=3257&view=diff&r1=3257&r2=3256&p1=trunk/scripts/prepare-kernel.sh&p2=/trunk/scripts/prepare-kernel.sh

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

