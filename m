Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Jun 2010 16:20:46 -0400
Message-ID: <6FCCA913376DD7488F4139A4D11B8F4801384570@domain.hid>
From: "Herrera-Bendezu, Luis" <lherrera@domain.hid>
Subject: [Xenomai-help] Shared memory and fstat()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,

Can a file descriptor returned from Xenomai POSIX skin
shm_open()/ftruncate() used in fstat()?

Value returned for st_size in the stat structure is
always 0 despite change of size using ftruncate().

Noticed that shared memory object does not have an entry
on /dev/shm as regular POSIX objects. Where is it located?
If entry exists, can it be used to query its size?

Thanks,
Luis

