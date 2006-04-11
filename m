Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Apr 2006 11:45:20 -0400
Message-ID: <067C9A1F6AFEB643895EA4513E116884178FF2@domain.hid>
From: "Moser, Dan" <DMoser@domain.hid>
Subject: [Xenomai-help] deleting a left over heap (shared memory segment)
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

Hi,

I was wondering if there was a command line method for deleting left
over heaps (i.e., those that were not properly deleted with a call to
rt_heap_delete()) from /proc/xenomai/registry/native/heaps.

Just a simple rm command (as root) yields the following:

# rm -f myshmem
cannot remove `myshmem': Operation not permitted

Thanks in advance for any help/insight,
Dan

