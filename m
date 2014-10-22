From: Steve Hartmann <shartmann@cnt.canon.com>
Date: Wed, 22 Oct 2014 11:09:30 +0000
Message-ID: <D06CF843.1966B%shartmann@cnt.canon.com>
References: <D06C3EF5.19661%shartmann@cnt.canon.com>
 <20141022050529.GA29673@sisyphus.hd.free.fr>
In-Reply-To: <20141022050529.GA29673@sisyphus.hd.free.fr>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DE85428DADA42147ABBD6D6EB80234FB@mex06.mlsrvr.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Troubleshooting general protection faults
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>


On 10/22/14 12:05 AM, "Gilles Chanteperdrix"
<gilles.chanteperdrix@xenomai.org> wrote:

>On Tue, Oct 21, 2014 at 09:48:55PM +0000, Steve Hartmann wrote:
>> Hi All,
>>=20
>> I am having a really strange and hard to troubleshoot problem on
>> multiple systems and hope that someone here could maybe throw some
>> tips my way.  I am running Xenomai 2.6.4 on linux 3.4.6, amd64.
>
>Do you observe the same behaviour with the I-pipe patch for Linux
>3.14.17 that comes with Xenomai 2.6.4?
>
>--=20
>					    Gilles.

Unfortunately there is no patched version of the e1000e driver for
Etherlabs Ethercat stack for that linux version, so I have not tried it.
I will look into the effort level to do the e1000e port myself.  Did you
mention that version because it addresses an issue similar to mine?


