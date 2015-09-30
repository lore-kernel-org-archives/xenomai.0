References: <CAL7_A_V5OGnUPxmGXOhz2=yiAcoJ4tXwR51-2krcxHcOY=xy6w@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <560BD3DD.8080405@xenomai.org>
Date: Wed, 30 Sep 2015 14:21:49 +0200
MIME-Version: 1.0
In-Reply-To: <CAL7_A_V5OGnUPxmGXOhz2=yiAcoJ4tXwR51-2krcxHcOY=xy6w@mail.gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Xenomai and RT Preempt Patch?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Jens_K=c3=b6hler?= <jenskxxx@googlemail.com>, xenomai@xenomai.org

On 09/30/2015 01:47 PM, Jens K=F6hler wrote:
> Hello,
>=20
> I have an application which uses Xenomai together with RTnet and a 2nd
> application which uses RT preempt patch. I like to run both applications =
at
> same computer.
>=20
> Is it possible to install Xenomai and RT preempt patch at same linux
> computer? And to run both applications?
>=20

Yes, but you will need to merge both the rt-preempt and ipipe patches
into a single kernel source tree, which is definitely possible (this has
been done several times in the past).

--=20
Philippe.

