Subject: Re: RTnet sendmmsg and ENOBUFS
From: Jan Kiszka <jan.kiszka@siemens.com>
References: <DB8PR05MB591594C16F703FD12F088928F6760@DB8PR05MB5915.eurprd05.prod.outlook.com>
 <1510f7f0-e130-0e22-b946-d1f6d84f3608@siemens.com>
 <DB8PR05MB59155D324BA2977A60E63DADF6760@DB8PR05MB5915.eurprd05.prod.outlook.com>
 <AM0PR05MB59064885C14E3DF057F2E9E8F6710@AM0PR05MB5906.eurprd05.prod.outlook.com>
 <815b192d-7ecf-385c-058e-969da641f7a4@siemens.com>
Message-ID: <c6e2e49c-bd58-f2f6-8d27-0de74121309d@siemens.com>
Date: Thu, 14 Nov 2019 19:39:58 +0100
MIME-Version: 1.0
In-Reply-To: <815b192d-7ecf-385c-058e-969da641f7a4@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 14.11.19 19:18, Jan Kiszka wrote:
> On 14.11.19 18:55, Lange Norbert wrote:
>> According to the code in __rtdm_fd_sendmmsg, that’s not what happens, 
>> ENOBUFS would be returned instead,
>> And the amount of sent packets is lost forever.
>>
>> if (datagrams > 0 && (ret == 0 || ret == -EWOULDBLOCK)) {
>> /* NOTE: SO_ERROR should be honored for other errors. */
>> rtdm_fd_put(fd);
>> return datagrams;
>> }
>>
>> IMHO this condition would need to added:
>> ((flags | MSG_DONTWAIT) && ret == -ENOBUFS)
>>
>> (Recvmmsg possibly similarly, havent checked yet)
> 
> sendmmsg was only added to Xenomai 3.1. There might be room for 
> improvements, if not corrections. So, if we do not return the number of 
> sent messages or signal an error where we should not (this is how I read 
> the man page currently), this needs a patch...

The implementation of sendmmsg is wrong when comparing it to the man 
page and the reference in the kernel (as this is Linux-only):

/* We only return an error if no datagrams were able to be sent */

says the kernel e.g. and does

         if (datagrams != 0)
                 return datagrams;

It's also missing to trace on certain exits. Will write a patch.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

