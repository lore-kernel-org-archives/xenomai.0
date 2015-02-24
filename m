From: =?iso-8859-1?Q?H=E4nel-Baas=2C_Alexander?=
 <alexander.haenel-baas@sieb-meyer.de>
Date: Tue, 24 Feb 2015 13:48:24 +0000
Message-ID: <9BA84827B30CBE4996725F98F7DC91234290300D@SMExchange01.siebmeyer.org>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] rt_heap_bind, Error=-11 -> EWOULDBLOCK why?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Aha
I added

vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot)
bevor i called remap_pfn_range

and now it works.

Thanks.

With best regards,
Alexander H=E4nel-Baas
