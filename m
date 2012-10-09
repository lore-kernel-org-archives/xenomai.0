MIME-Version: 1.0
Date: Tue, 9 Oct 2012 14:32:58 +0200
Message-ID: <CANKLDmtLLcZnbJ5vXJFRkdyoy1Qk_wfGR84LdB0dkb8KynS+Yg@mail.gmail.com>
From: Henri Roosen <henriroosen@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Exporting __ipipe_get_cs_tsc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I'm using the current git heads of core-3.4 and xenomai 2.6.1 for x86
with the attached config file.

When compiling the modules I get undefined symbols:
ERROR: "__ipipe_get_cs_tsc" [kernel/xenomai/skins/posix/xeno_posix.ko]
undefined!

This is because the run time seleted __ipipe_get_cs_tsc assembly
function is not exported for module use.
I don't know how to export this or whether the symbol should be used
by modules in the first place.

Please advice.

Thanks,
Henri.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config
Type: application/octet-stream
Size: 57776 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20121009/524a051=
6/attachment.obj>
