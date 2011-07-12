Message-ID: <4E1BF6E6.1000802@domain.hid>
Date: Tue, 12 Jul 2011 09:25:26 +0200
From: Kim Mathiassen <kimmat@domain.hid>
MIME-Version: 1.0
References: <4E1AFA51.3090209@domain.hid> <4E1B04FA.7000209@domain.hid>
In-Reply-To: <4E1B04FA.7000209@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with periodic posix thread
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

On 07/11/2011 04:13 PM, Gilles Chanteperdrix wrote:
> On 07/11/2011 03:27 PM, Kim Mathiassen wrote:
>> Hi
>>
>> I have som problems creating a periodic posix thread. When I call
>> pthread_make_periodic_np it returns 3 (ESRCH). I have created the
>> following test:
> Do you obtain the compilation flags as explained here?
>
> http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#Compilation_flags
>
Thanks. Now it works.

