Message-ID: <465D6D4A.5060009@domain.hid>
Date: Wed, 30 May 2007 14:25:46 +0200
MIME-Version: 1.0
References: <465D2BE1.1080302@domain.hid> <465D3053.2040002@domain.hid>	
	<465D383C.5040203@domain.hid> <465D3B37.9000900@domain.hid>	
	<465D435F.8080304@domain.hid>
	<b647ffbd0705300500t4c663883r723525ab8d977e85@domain.hid>
In-Reply-To: <b647ffbd0705300500t4c663883r723525ab8d977e85@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Rodolfo Bamberg <rolfetas@domain.hid>
Subject: Re: [Xenomai-help] [Newbie question]Segmentation fault with
 user-space binary
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

Dmitry Adamushko wrote:
> On 30/05/07, Rodolfo Bamberg <rolfetas@domain.hid> wrote:
>> I just can't figure out: If latency works, and it uses the native skin,
>> why does including libnative throw a segmantation fault?
>>
>
> Do you have Xenomai support built in-kernel or in external modules?
> How do you run your application and latency (i.e. do you actually
> launch the "latency"'s executable)?
>
> Probably, it shouldn't be a case (I don't remember all the
> installation/runtime details by heart any more) but be sure the
> xenomai modules are loaded by the moment your application starts.
>
> Although, I'd expect some more user-friendly behavior from the
> libnative in such a case.. so maybe it's not a case.
>
> Get a core dump when it crushes and feed it to "gdb".. maybe you'll
> have some relevant bits from the stacktrace.
>
>
Xenomai support is built-in within the Kernel. Latency works for both
Kernel and User-Space modes, as an executable. Is there any other way to
use latency? as a kernel loadable module? I will try to bind-statically
everything with Xenomai support to the Kernel and see if it makes a
change. If not I'll try to cross-debug my app.


