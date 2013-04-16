Message-ID: <516CF7D4.9070000@xenomai.org>
Date: Tue, 16 Apr 2013 09:03:48 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAPpP=rPQa-Fa+1j7Lb11dUX8srkinCQQ2yS2gR5y9f9Pqf1jdg@mail.gmail.com>	<516998B7.9090901@xenomai.org>	<CAPpP=rOEjuy8w0x-_zRv_7vHDOmjU6n1Hi=jrE6UNEULL=zYcQ@mail.gmail.com>	<5169C63B.1070406@xenomai.org>	<CAPpP=rMOmOkd2Gwswu685zsPhxJDMj7GnRWA0yU+gRHmz=V2bw@mail.gmail.com>	<5169EC2C.4000101@xenomai.org>	<CAPpP=rNCBdcussSRzHN_Vpjj0afWZRGKRqPXxh7ps2-_GP7nBQ@mail.gmail.com>	<516BC4DF.3030302@xenomai.org>	<CAPpP=rMRx5CKj2uJv3wBSu=UUb88W2nXy73z1B6ewBgXEQNYiQ@mail.gmail.com>	<516BF43D.7070708@xenomai.org>	<CAPpP=rPLiziMZU8-KUQvsfcUr8MbXh9pTeobuTO+HRfGtizJPw@mail.gmail.com>	<516C094F.2050107@xenomai.org>	<CAPpP=rMsqp5SOfq8_dNUOZ5UFugNa-YwsLyT5WT4d01_UTWRMA@mail.gmail.com>
	<516C0E3B.5050606@xenomai.org> <516C58C3.1080404@xenomai.org>
In-Reply-To: <516C58C3.1080404@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [QUESTION] thread creation and hook function
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 04/15/2013 09:45 PM, Gilles Chanteperdrix wrote:
> On 04/15/2013 04:27 PM, Philippe Gerum wrote:
>
>> On 04/15/2013 04:18 PM, alex alex wrote:
>>> pthread_set_name_np is called after the task creation and it seems that
>>> the *_np function force to switch in secondary too...
>>
>> No, it does not. Maybe you should double-check the way you determine
>> mode switches.
>
>
> Yes, using SIGDEBUG is the recommended way to understand mode switches.
> Anyway, a reason for parasite mode switches could be that Alexandre is
> using the 3.2.21 kernel, which we know has issues with mprotect, maybe
> he gets additional page faults?
>
>

In that case he should see reports of forced switches to secondary mode 
in the kernel log, provided CONFIG_XENO_DEBUG_NUCLEUS is enabled.

-- 
Philippe.

