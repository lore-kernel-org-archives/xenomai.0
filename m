Message-ID: <533B270F.4060702@xenomai.org>
Date: Tue, 01 Apr 2014 22:52:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5339E2CE.7060703@xenomai.org>
 <20140331215348.GX17765@csclub.uwaterloo.ca>
 <20140331215933.GY17765@csclub.uwaterloo.ca>
 <20140331220421.GZ17765@csclub.uwaterloo.ca> <5339E80C.9020604@xenomai.org>
 <5339EBE1.3060907@xenomai.org> <20140401013227.GA17765@csclub.uwaterloo.ca>
 <533A9A7C.7020408@xenomai.org> <20140401131257.GB17765@csclub.uwaterloo.ca>
 <533B14FC.1000007@xenomai.org> <20140401194053.GC17765@csclub.uwaterloo.ca>
In-Reply-To: <20140401194053.GC17765@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Porting xenomai 2.6.3 and ipipe to 3.12 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On 04/01/2014 09:40 PM, Lennart Sorensen wrote:
> On Tue, Apr 01, 2014 at 09:35:24PM +0200, Gilles Chanteperdrix wrote:
>> On 04/01/2014 03:12 PM, Lennart Sorensen wrote:
>>> On Tue, Apr 01, 2014 at 12:52:44PM +0200, Gilles Chanteperdrix wrote:
>>>> The way I test it is by running xeno-regression-test, using dohell with
>>>> LTP to create a load. Note that the latency result given by
>>>> xeno-regression-test should not be taken into account as switchtest is
>>>> running concurrently and creates large non-preemptible sections,
>>>> xeno-regression-test is more a stress test.
>>>
>>> I will see if I can find the invocation to run that then.
>>>
>>> I let cyclictest, switchtest and latency running the last 8 hours,
>>> and latency test currently says:
>>>
>>> RTD|     -0.814|      2.441|      7.486|       0|     0|     -2.116|     20.182
>>>
>>> That seems decent at least.
>>>
>>
>> I use:
>> xeno-regression-test -l "dohell -s 192.168.0.5 -m /mnt -l /ltp"
>>
>> Where the machine with ip 192.168.0.5 has the "discard" service enabled
>> (port 9, available in inetd), an usb key is mounted on /mnt, and LTP is
>> installed in /ltp.
> 
> I get an error when I use the -s option.

Probably because the machine with the IP address you pass after -s does
not have the "discard" service enabled in inetd.conf

> 
> I ran out of space, so ltp is instaled on the usb key mounted at /mnt.
> Hopefully it won't mind that.
> 
> ++ /usr/lib/xenomai/testsuite/regression/posix/xddp_test
> FAILURE xddp_test.c:41: socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_XDDP): Address family not supported by protocol

> 
> Maybe I am mising a kernel config.

Well, you need to enable xddp.

-- 
                                                                Gilles.

