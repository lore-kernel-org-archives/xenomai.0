Message-ID: <549348E3.4070701@nta-inc.net>
Date: Thu, 18 Dec 2014 15:36:35 -0600
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
References: <5490A954.8040207@nta-inc.net>
 <20141217103118.GB7151@hermes.click-hack.org> <5492E634.3040605@nta-inc.net>
 <20141218144910.GO2012@hermes.click-hack.org>
In-Reply-To: <20141218144910.GO2012@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [RTnet-users] Add "rtroute solicit" support to the
 rtnet script and rtnet.conf
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: rtnet-users@lists.sourceforge.net, Xenomai <xenomai@xenomai.org>

On 12/18/2014 08:49 AM, Gilles Chanteperdrix wrote:
> On Thu, Dec 18, 2014 at 08:35:32AM -0600, Jeff Webb wrote:
>> On 12/17/2014 04:31 AM, Gilles Chanteperdrix wrote:
>>> On Tue, Dec 16, 2014 at 03:51:16PM -0600, Jeff Webb wrote:
>>>> I am using rtnet without rtmac/tdma. I previously sent a patch
>>>> that allows one to use the "rtnet" script and rtnet.conf in this
>>>> configuration. I would also like to be able to specify a list of
>>>> IP addresses in rtnet.conf that are passed along to "rtroute
>>>> solicit". I have attached patches for the rtnet and
>>>> xenomai-3.git/next repositories. I think others will find them
>>>> useful.
>>>
>>> Well, you should probably be using "nomac" if you are not interested
>>> in tdma.
>>>
>>
>> Thank you for your response. I appreciate your advice, Gilles, and
>> even more so, since I am new to RTnet. I am somewhat confused by
>> the rtmac/nomac configuration, since I haven't found a lot of
>> documentation on it. Something I read indicated that the primary
>> purpose was for use as skeleton when writing new MAC
>> implementations, but it also seems that it is useful for other
>> purposes. I have a couple questions that might clarify things for
>> me a bit.
>>
>> There are a couple of ASCII-art drawings at the beginning of the
>> README.rtmac file in the rtnet documentation. The first one seems
>> to indicate that rtnet can be used without rtmac, if all
>> communication is done from RT applications. I see that with rtmac
>> inserted, standard linux programs can also send information over
>> the real-time interface. The RTmac.spec document indicates that
>> the rtmac layer wraps data sent through rtmac with an rtmac frame
>> header, and specifies how the non-real-time packets can be
>> tunneled through a real-time network. My first question is: does
>> the rtmac/nomac configuration still add the rtmac header? I
>> assumed the answer was "yes", but perhaps I am wrong.
>
> The answer is yes, but only for the packets sent from non real-time
> applications. The UDP packets sent using RTnet sockets are plain IP
> packets compatible with normal IP stacks.
>
>>
>> My initial RTnet application is to send UDP packets in real-time
>> to a hardware device manufactured by someone else. Since I am not
>> in control of the receiving device, I cannot have any additional
>> headers added to my packets. Can I do this without the rtmac
>> module inserted? Can I do this with rtmac and nomac inserted? If
>> so, what would be the advantage in my application? At some point I
>> may need to send/receive TCP and UDP packets for non-real-time
>> configuration purposes, but I don't see any need to communicate
>> from standard linux programs at this time.
>>
>> Thank you again to everyone for their input. The documentation is
>> not very clear on how (or even if) rtnet can be used to do what I
>> need.
>
> To be able to send plain IP packets using Linux sockets without the
> rtmac tunneling, you can use rtnetproxy. The problem with rtnetproxy
> is that it creates only one linux interface, and then routing is
> done by rtnet. While it may be sufficient for typical applications,
> it is insufficient for network oriented equipments which need
> NAT, or per-interface QOS settings.
>
> A solution to this need is to create, like rtmac does, one linux
> interface by rtnet interface, but do not do the tunneling that rtmac
> does. A long time ago, when I worked for a company which was using
> RTnet, I did exactly that, modifying the nomac policy, but the
> patches did not went far into rtnet (you can probably find them in
> rtnet archives though).
>
> My plan is to do the same thing, but adding a new mac policy which
> would be dubbed xmac (like cross-mac) in xenomai 3 tree. I can not
> make any promise on that though, since I have plenty to do already
> with rtnet, as I have posted. Ideally, what I would like to do, is
> to have, for each NIC, one RT interface which gives good latencies,
> and a plain linux interface which allows high throughput.
>

Thanks, Gilles.  That explanation helps a lot.

-Jeff


