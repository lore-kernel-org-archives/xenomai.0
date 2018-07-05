From: Philippe Gerum <rpm@xenomai.org>
References: <6b3f6665-d424-9350-837f-cad1b3b54c7c@gmx.at>
 <d72ffe7c-500d-4fa2-8643-ac82fbe619f1@xenomai.org>
 <VI1PR0801MB18548FC46353D8A7836127A2F5400@VI1PR0801MB1854.eurprd08.prod.outlook.com>
 <d5b902a5-05b7-ae28-c2d5-e04c0e8b6f6c@xenomai.org>
Message-ID: <cd3e2dc1-2238-22db-8115-34030f102a07@xenomai.org>
Date: Thu, 5 Jul 2018 16:41:27 +0200
MIME-Version: 1.0
In-Reply-To: <d5b902a5-05b7-ae28-c2d5-e04c0e8b6f6c@xenomai.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] context switch minimize
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Johann Obermayr <johann.obermayr@sigmatek.at>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/05/2018 04:14 PM, Philippe Gerum wrote:
> On 07/05/2018 04:08 PM, Johann Obermayr wrote:
>>
>>
>>> -----Ursprüngliche Nachricht-----
>>> Von: Xenomai [mailto:xenomai-bounces@xenomai.org] Im Auftrag von
>>> Philippe Gerum
>>> Gesendet: Donnerstag, 5. Juli 2018 15:05
>>> An: jimmyo <jimmyo@gmx.at>; xenomai@xenomai.org
>>> Betreff: Re: [Xenomai] context switch minimize
>>>
>>> On 07/05/2018 11:37 AM, jimmyo wrote:
>>>> Hello,
>>>>
>>>> we have a running system on mx6 with Kernel 3.10.x and Xenomai 2.6.4.
>>>> i known, it's very old.
>>>> now we have to make some optmization.
>>>> In one xenomai task we need to check, if a TCP/UDP socket handle has
>>>> data to receive.
>>>> at this time we use select to detect if there are data available and
>>>> with ioctl & FIONREAD we get count of data.
>>>>
>>>> Now we must search a way, to do this in the primary domain, without
>>>> switching to secondary domain.
>>>>
>>>> Is there a way to solve it ?
>>>>
>>>> we have a exists rtdm interface to a own kernel module.
>>>> And we use rt_dev_ioctl to communicate with this module.
>>>>
>>>
>>> A plain thread could select() these file descriptors in userland, posting a
>>> Xenomai-managed semaphore which your rt thread would trywait() on.
>>>
>>> - semaphores can be posted by any thread, including those unknown to
>>> Xenomai
>>> - sem_trywait() would poll for the event without switching mode.
>>>
>>> --
>>> Philippe.
>>>
>>> _______________________________________________
>>> Xenomai mailing list
>>> Xenomai@xenomai.org
>>> https://xenomai.org/mailman/listinfo/xenomai
>>
>> Hello,
>>
>> We also thought about our own thread but wanted to know if there is a better solution.
>>
> 
> None that would be as simple.
> 

The other way, would you fancy smashing flies with nukes, would be to
have your RTDM driver create a regular netdev, that you would attach to
a network bridge along with all the network interfaces receiving traffic
of interest to your rt task. In the xmit handler of that netdev, you
would be free to issue whatever synchronization/signal to your rt task
announcing incoming data, before passing the socket buffers along to the
next layer.

-- 
Philippe.

