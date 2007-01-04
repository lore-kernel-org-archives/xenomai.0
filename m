Message-ID: <459D4710.3070403@domain.hid>
Date: Thu, 04 Jan 2007 19:27:28 +0100
From: Markus Franke <Markus.Franke@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] parallelport module for
	measuring	external	interrupt latency
References: <459B6DAD.4030406@domain.hid>	<459B7C6C.9030401@domain.hid>	<459B8382.7060508@domain.hid>	<459B8A19.2060809@domain.hid>
	<459C13C5.9010007@domain.hid>
	<459CC4D9.9080404@domain.hid>
In-Reply-To: <459CC4D9.9080404@domain.hid>
Content-Type: multipart/mixed; boundary="------------000703080506060201040802"
Reply-To: Markus.Franke@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------000703080506060201040802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Anders Blomdell wrote:
> The code looks OK, but if you hit some unsigned - signed - unsigned
> conversion during wraparounds, the latencies experienced suggest that
> you run a 1.5 GHz computer (or possibly a 3GHz, never get the 2^32 vs
> 2^31 stuff right):
> 
>   2^31/1.5 -> 1.4317e+09 Hz
> 
> BTW: Why not use the 64 bit value from rdtsc (but storing the diff in a
> 32 bit quantity to get the divide right in kernel space)?.

This was a rather good idea. I changed it in a way you suggested.
Another problem was that I wrote something like:

outb(...)
rdtsc(start_time)

Sometimes the ISR set up end_time before the start_time could be set.
This was another problem. I just swapped the two lines above and reduced
 the measured time by the overhead which is incured by rdtsc(). The
results look quite reasonable.

Regards,
Markus

--------------000703080506060201040802
Content-Type: text/x-vcard; charset=utf-8;
 name="Markus.Franke.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Markus.Franke.vcf"

begin:vcard
fn:Markus Franke
n:Franke;Markus
adr;quoted-printable:;;Vettersstra=C3=9Fe 64/722;Chemnitz;Saxony;09126;Germany
email;internet:Markus.Franke@domain.hid
x-mozilla-html:FALSE
url:http://www.tu-chemnitz.de/~franm
version:2.1
end:vcard


--------------000703080506060201040802--

