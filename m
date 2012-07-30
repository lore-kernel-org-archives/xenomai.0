Message-ID: <50162F5D.2050706@xenomai.org>
Date: Mon, 30 Jul 2012 08:53:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <208C6975C932E94F86239FEA59CCA632068318D3@AUSMXMBX02.mrws.biz>	<5012B995.8080909@xenomai.org>
	<208C6975C932E94F86239FEA59CCA632068319E7@AUSMXMBX02.mrws.biz>
In-Reply-To: <208C6975C932E94F86239FEA59CCA632068319E7@AUSMXMBX02.mrws.biz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH, Xenomai 2.5.6]
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: dietmar.schindler@manroland-web.com
Cc: xenomai@xenomai.org

On 07/30/2012 08:42 AM, dietmar.schindler@manroland-web.com wrote:

>> -----Original Message----- From: Gilles Chanteperdrix
>> [mailto:gilles.chanteperdrix@xenomai.org] Sent: Friday, July 27,
>> 2012 5:54 PM
>> 
>> On 07/27/2012 02:45 PM, dietmar.schindler@manroland-web.com wrote:
>> 
>>> These are patches for two files in ksrc/nucleus of Xenomai 2.5.6
>>> to cure an incompatibility with Linux 2.4; if they are bad in
>>> form, please let me know.
>> 
>> 
>> This is kind of you to provide the patch, but I do not think we
>> are going to issue any new release in the 2.5 branch.
>> 
>> Even though 2.6 is technically a new branch, with a different ABI,
>> very few things (actually, none that come to my mind) have changed
>> in the API, so, the update should be painless.
> 
> At
> http://www.xenomai.org/index.php/Xenomai:News#2010-10-06_Xenomai_2.5.5.1
> I read: "Note: Xenomai 2.5.5 is the last release to contain a patch
> for Linux 2.4 on x86 ..."; thence I blindly assumed that Xenomai 2.6
> would not work with Linux 2.4 - did I go astray?


Yes, xenomai 2.6 still works with Linux 2.4 (or is supposed to, we just
compile-test) even though it does not include the patch.

> Besides that, with
> third-party software as e. g. ProConOS, it might not be easily
> possible to update the Xenomai branch.


Unfortunately, there is nothing we can do about that. We let 6 months
between the 2.6.0 and 2.6.1 release, it can not be said that we release
to often.


-- 
                                                                Gilles.

