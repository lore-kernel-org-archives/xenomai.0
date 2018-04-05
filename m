From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Thu, 5 Apr 2018 11:15:19 +0000
Message-ID: <DB6PR0701MB245618054AEE22508685BDE4B5BB0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
References: <DB6PR0701MB2456EF1925C87F170E90540EB5A40@DB6PR0701MB2456.eurprd07.prod.outlook.com>,
 <7528e4df-ac06-8893-bf77-7cbf9e91eeef@xenomai.org>
In-Reply-To: <7528e4df-ac06-8893-bf77-7cbf9e91eeef@xenomai.org>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] xeno-config --no-mode-check still has -lmodechk
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

so would it not be up to the external libs to specify in their docs that th=
ey should be linked with -lmodechk?
________________________________________
From: Philippe Gerum <rpm@xenomai.org>
Sent: 05 April 2018 07:43
To: Giulio Moro; xenomai@xenomai.org
Subject: Re: [Xenomai] xeno-config --no-mode-check still has -lmodechk

On 04/04/2018 09:58 PM, Giulio Moro wrote:
>  /usr/xenomai/bin/xeno-config --skin cobalt --ldflags --no-mode-check
>
> returns
> -Wl,--no-as-needed   /usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=3Dma=
in -Wl,--dynamic-list=3D/usr/xenomai/lib/dynlist.ld -L/usr/xenomai/lib -lco=
balt -lmodechk -lpthread -lrt
>
> which removes the modechk wrappers, but leaves -lmodechk in. Is this expe=
cted?
>
> As I understand it, libmodechk provides implementations for __wrap_malloc=
, __wrap_free and __real_malloc, __real_free() are these needed even when t=
he wrappers are disabled, or should -lmodechk not be included?
>
>

The main exec may still depend on external libs built with mode checking
wrappers.

--
Philippe.

