MIME-Version: 1.0
In-Reply-To: <4A117241.5080104@domain.hid>
References: <abaf774b0905180656y4eddca23h6241c9dc031a3ba4@domain.hid>
	<4A116AC5.7010704@domain.hid> <4A116D6D.7020105@domain.hid>
	<4A116EA1.6050303@domain.hid> <4A117241.5080104@domain.hid>
Date: Mon, 18 May 2009 16:08:04 +0100
Message-ID: <abaf774b0905180808t43991e35q1e4fda4675b37beb@domain.hid>
From: Steve <sbxenomai@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] select(2) generates EFAULT
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

On 18/05/2009, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Steve wrote:
>>>>> First, thank you for the help on my previous query.
>>>>>
>>>>> I am still working on porting a c++ application from RTAI to Xenomai,
>>>>> and have encountered a problem with sockets, specifically the select
>>>>> function.
>>>>>
>>>>> When Xenomai is not being used the code runs as expected.  Once the
>>>>> Xenomai headers, compile options, etc, are used the select function
>>>>> fails with the error EFAULT.  I have reproduced the error (works
>>>>> without Xenomai, EFAULTs with Xenomai) using the following program:
>>>>>
>>>>> #include <stdio.h>
>>>>> #include <arpa/inet.h>
>>>>> #include <errno.h>
>>>>>
>>>>> int handleError(char *msg, int err);
>>>>>
>>>>> int main(void)
>>>>> {
>>>>>    int sfd;
>>>>>    struct sockaddr_in sai;
>>>>>    fd_set SockSet;
>>>>>    struct timeval tv;
>>>>>    tv.tv_sec = 2;
>>>>>    tv.tv_usec = 0;
>>>>>
>>>>>    sai.sin_family = AF_INET;
>>>>>    sai.sin_port = htons(1025);
>>>>>    sai.sin_addr.s_addr = htonl(INADDR_ANY);
>>>>>
>>>>>    if((sfd = socket(AF_INET, SOCK_STREAM, 0)) == -1)
>>>>>    { return handleError("creation error", errno); }
>>>>>
>>>>>    if(bind(sfd, (struct sockaddr*)&sai, sizeof(sai)) == -1)
>>>>>    { return handleError("bind error", errno); }
>>>>>
>>>>>    if(listen(sfd, 5) == -1)
>>>>>    { return handleError("listen error", errno); }
>>>>>
>>>>>    FD_ZERO(&SockSet);
>>>>>    FD_SET(sfd, &SockSet);
>>>>>
>>>>>    if(select(sfd+1, &SockSet, 0, 0, &tv) == -1)
>>>>>    { return handleError("select error", errno); }
>>>>>
>>>>>    printf("success\n");
>>>>>
>>>>>    return 0;
>>>>> }
>>>>>
>>>>> I am using Xenomai 2.4.6.1 on a vanilla 2.6.24.6 Linux kernel, and
>>>>> running on Ubuntu 8.04.
>>>> Could you try 2.4.7, to see if you are not having a bug which has
>>>> already been fixed?
>>>>
>>>> What you are trying should work, even though you are not really using
>>>> Xenomai's select but Linux plain select.
>>> This should have been fixed in 2.4.x.git - if my patch were applied. See
>>> git://git.xenomai.org/xenomai-jki.git for-2.4.x
>>>
>>> Did I missed to post some correction of that version, or what delays
>>> this? Sorry, lost track of it.
>>
>> Sorry, I do not see what patch you are refering to. Is it:
>> http://git.xenomai.org/?p=xenomai-jki.git;a=commitdiff;h=86333965a4362f8439822ec9d22b0a84b5701141;hp=a219c4a71b381f4662df45bac5508c3ae64ab924
>>
>> In this commit, I only see things which should return more -EFAULT. Or
>> did I miss something?
>
> I mean
> http://git.xenomai.org/?p=xenomai-jki.git;a=commitdiff;h=8542b9dc56b9edd16dab69e930699bcee17fa6ac
>
> That should be...
> http://permalink.gmane.org/gmane.linux.real-time.xenomai.devel/6237
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT SE 2
> Corporate Competence Center Embedded Linux
>

I am in the process of re-compiling the kernel with the 2.4.7, and I
have just checked the fault number of my example; it is definitely
giving +14, not -14 (so EFAULT, not -EFAULT).  Might this be an issue
with my kernel config options rather than anthing else?

Steve

