From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Wed, 29 Nov 2017 16:52:17 +0000
Message-ID: <DB6PR0701MB24565B00938AD1BED040C5F9B53B0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
References: <DB6PR0701MB2456EB08FE752DA5BF73FF6DB53A0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
 <DB6PR0701MB24569056BAB353E42210D9CAB53A0@DB6PR0701MB2456.eurprd07.prod.outlook.com>,
 <b095c725-4e15-6618-5af2-1790c0a0926c@xenomai.org>
In-Reply-To: <b095c725-4e15-6618-5af2-1790c0a0926c@xenomai.org>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Library cannot be dlopen()ed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

> From: Philippe Gerum <rpm@xenomai.org>
> As mentioned in the documentation, --enable-dlopen-libs is needed when co=
nfiguring

Brilliant, thanks. The docs mentions

> Enabling dynamic loading introduces some overhead in TLS accesses when en=
abled (see --enable-tls), which might be noticeable depending on the archit=
ecture.

Can you make an example of what operations incur overhead?

Thanks,
Giulio=

