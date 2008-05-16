Message-ID: <2ff1a98a0805160909r19c9ab0fsc0b838bcc306a1ea@domain.hid>
Date: Fri, 16 May 2008 18:09:58 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <62ac12da32c026b0097185dff53fe0d8@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ff1a98a0805160149w3478755bqa4ffa44dfc7107b0@domain.hid>
	<62ac12da32c026b0097185dff53fe0d8@domain.hid>
Subject: Re: [Xenomai-help] VxWorks skin problem concerning WIND_TCBstructure
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: matthieu.connaulte_xenomai@domain.hid
Cc: xenomai@xenomai.org

On Fri, May 16, 2008 at 12:11 PM, Matthieu
<matthieu.connaulte_xenomai@domain.hid> wrote:
>> I suggest you patch your kernel with the patch Philippe sent, adapt it
>> to suit your needs, maybe changing TASK_DESC as in vxworks taskLib.h,
>> test and debug it, then send us a patch which we will be happy to
>> merge.
>>
>> --
>>  Gilles
>
> Ok, I was about doing it.
>
> I still have some questions about the migration of my app, as I don't know
> Xenomai in details.
>
> Here is part of my code which aims at defining a procedure to restart a
> task. If you have time to have a look on it, it would be helpful.

taskRestart is not supported in user-space by the VxWorks skin. So,
the first thing to do is to check if your application really needs
this service, and if it does, implement taskRestart.

-- 
 Gilles

