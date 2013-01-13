Message-ID: <50F30CB8.7000001@zultron.com>
Date: Sun, 13 Jan 2013 13:36:24 -0600
From: John Morris <john@zultron.com>
MIME-Version: 1.0
References: <50F19CE1.5080106@zultron.com> <50F1B37E.3030502@xenomai.org>
	<50F23AA2.3080102@zultron.com> <50F2BC64.408@xenomai.org>
In-Reply-To: <50F2BC64.408@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] SMI workarounds in one-size-fits-all kernel packages
 (Was: Re: Kernel OOPS during regression tests)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>



On 01/13/2013 07:53 AM, Gilles Chanteperdrix wrote:
> On 01/13/2013 05:40 AM, John Morris wrote:
> 
>>
>>
>> On 01/12/2013 01:03 PM, Gilles Chanteperdrix wrote:
>>> On 01/12/2013 06:26 PM, John Morris wrote:>
>>>
>>>> The kernel is built from the elrepo.org kernel, and this config file
>>>> overrides the upstream config; makes it easy to see the Xenomai-specific
>>>> changes:
>>>> https://github.com/zultron/kernel-ml/blob/branch3.5.3-xeno/config-3.5.3-xenomai-x86_64
>>>
>>>
>>> It seems a really bad idea to enable the SMI workaround by default.
>>>
>>
>> Thanks!  Despite feeling uncomfortable contradicting the documentation,
>> I was encouraged to turn this on by someone more authoritative than me.
>>  It does seem like a separate package with it turned on is warranted for
>> those who have problems and have been fairly warned about the risk.
> 
> 
> I guess we should turn the compile-time option into a kernel parameter.
> So, the smi workaround would be disabled by default, and only enabled
> when passing a kerne command-line option.

That would be ideal!

	John

