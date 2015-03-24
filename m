Message-ID: <55117747.6040807@web.de>
Date: Tue, 24 Mar 2015 15:40:07 +0100
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <CAKC9m6dkbD2iwi62YP_O2wRiOUHNp17eoMLYP6okg=PQ0OgjxQ@mail.gmail.com>
 <20150320181308.GA27775@hermes.click-hack.org>
 <CAKC9m6eFoRrFj_QteNeJmcbi+eir0SGzwoCTd2TVzPVuqDsiCQ@mail.gmail.com>
 <20150321131111.GA20203@hermes.click-hack.org>
 <20150321132130.GC20203@hermes.click-hack.org>
 <CAKC9m6ceEi593XX04-dLfQaVYHmQHmwe75oC+d4Qu-t9q1G9_A@mail.gmail.com>
 <550FD6CA.7080407@web.de> <20150323095340.GA5299@hermes.click-hack.org>
 <55101C6F.2030207@web.de> <20150323152540.GC5299@hermes.click-hack.org>
In-Reply-To: <20150323152540.GC5299@hermes.click-hack.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] ARMv8 (ARM64) port of Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 2015-03-23 16:25, Gilles Chanteperdrix wrote:
> On Mon, Mar 23, 2015 at 03:00:15PM +0100, Jan Kiszka wrote:
>> There is a trend in industry towards virtual targets. That's because you
>> can do much more (and much earlier) with emulation than with real hw,
>> and handling is much easier (no wiring, no physical reset, free
>> replication of setups etc.).
> =

> Being a trend does not mean this is a good idea. I still believe a
> lot of people using JTAG or gdb tend to see symptoms rather than
> real issue and misinterpret them.

Yeah, real developers don't use debuggers or similar tools. Linus made a
similar statement some decade ago. He was wrong with this generalization
as well - one reason why we have kgdb upstream now. Debugging done right
is interactive code reading and model checking.

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150324/c0fb581=
2/attachment.sig>
