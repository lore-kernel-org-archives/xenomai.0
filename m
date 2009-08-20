Message-ID: <4A8D295C.2080402@domain.hid>
Date: Thu, 20 Aug 2009 12:45:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <abaf774b0908040623w1583f930xda88c125b64394b1@domain.hid>	<4A7BC4DC.70209@domain.hid>	<abaf774b0908190127y4092620cr9c19b65b6434d7b1@domain.hid>	<4A8BBA87.5010305@domain.hid>	<abaf774b0908190229q4d1e0641wfc2d6927a8b34e42@domain.hid>	<4A8BC7BE.5020201@domain.hid>
	<abaf774b0908190246j61f0e841s60a1b284ab1bb86@domain.hid>
In-Reply-To: <abaf774b0908190246j61f0e841s60a1b284ab1bb86@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai 2.5-rc2 clock_gettime bad tv_nsec value
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve <sbxenomai@domain.hid>
Cc: xenomai@xenomai.org

Steve wrote:
> On 19/08/2009, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>> Steve wrote:
>>> Were you going to delay handling this until later, or were you hoping
>>> it wouldn't be a problem?  If it's the former then this is not my
>>> number one priority at the moment, so from my perspective I can wait
>>> until the next release candidate / release.
>> To be completely frank, I was not really worried about this issue, since
>> you had not answered, I thought that maybe the issue was in your test
>> program.
>>
>>> Linux kernel: 2.6.29.4
>>> Xenomai: 2.5-rc2
>>> Adeos: adeos-ipipe-2.6.29.4-x86-2.4-01
>>>
>>> OS: Ubuntu (8.04 with updates)
>>> Hardware:
>>> Intel Core 2 CPU, kernel compiled using processor family 'Pentium-4/etc'
>> compiled for 32 or 64 bits?
>>
>> --
>>                                           Gilles
>>
>>
> 
> 32 bit,

Ok. It turns out that the error is portable, and there is no other way
than to fix the result after the multiplication (trying to round
differently leads to the converse error). So, could you try the
following patch:

diff --git a/include/asm-generic/bits/timeconv.h
b/include/asm-generic/bits/time
index 79060b3..aa595fe 100644
--- a/include/asm-generic/bits/timeconv.h
+++ b/include/asm-generic/bits/timeconv.h
@@ -60,10 +60,17 @@ long long xnarch_ns_to_tsc(long long ns)
 unsigned long long xnarch_divrem_billion(unsigned long long value,
                                         unsigned long *rem)
 {
-       unsigned long long r;
-       r = xnarch_nodiv_ullimd(value, bln_frac.frac, bln_frac.integ);
-       *rem = value - r * 1000000000;
-       return r;
+       unsigned long long q;
+       unsigned r;
+
+       q = xnarch_nodiv_ullimd(value, bln_frac.frac, bln_frac.integ);
+       r = value - q * 1000000000;
+       if (r >= 1000000000) {
+               ++q;
+               r -= 1000000000;
+       }
+       *rem = r;
+       return q;
 }
 #else /* !XNARCH_HAVE_NODIV_LLIMD */
 long long xnarch_ns_to_tsc(long long ns)


-- 
					    Gilles.

