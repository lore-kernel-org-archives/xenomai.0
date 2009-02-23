Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Feb 2009 16:32:48 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D590FDA@slcmail.slc.mew.int>
In-Reply-To: <49A29232.5060003@domain.hid>
References: <499EBF45.900@domain.hid> <49A29232.5060003@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] [PATCH] x86: Proper root domain state management
	for ipipe_handle_exception
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

I ran my old FPU test on this just for fun and got the following OOPS:

Eeek! Page_mapcount(page) went negative! (-1)
Page pfn =3D 0
Page->flags =3D 14
Page->count =3D ffffffff
Page->mapping =3D 00000000
Vm->vm_ops =3D 0
BUG at mm/rmap.c:684

In page_remove_rmap

I also see "fixing recursive fault but reboot needed"

Steven


