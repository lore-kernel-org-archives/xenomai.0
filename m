Message-ID: <b647ffbd0702280135l29ae408ewfe459d85ef2c41d1@domain.hid>
Date: Wed, 28 Feb 2007 10:35:55 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] Semaphore Task
In-Reply-To: <e45fe62b0702280117k23198918y971763b877cd9b9a@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e45fe62b0702280117k23198918y971763b877cd9b9a@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Preetam Joshi <j.preetam@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 28/02/07, Preetam Joshi <j.preetam@domain.hid> wrote:
> Hi i have a problem in my code the rt_sem_create calls returns a negative
> value i.e. -17
>
> THat is semaphore creation fails? Why is it so?

rt_sem_create()'s docs describe all the possible return values. -17 ==
-EEXIST (it's one of the possible errno values you may find in the
standard libc include files).

What probably happens in your case is as described below:

(look at the section for semaphores in /proc/xenomai/registry/)

-----------------------------------------------
> 1. On program start after previous crash i unable to create named mutex,
> because it [-EEXIST], after bind it's unable to operate with it because
> it locked by task from early died program, i have to restart computer.
> Any suggestions?

Something like this would do:

if (rt_mutex_bind("...", &desc) == 0)
       rt_mutex_delete(&desc);

rt_mutex_create("...", &desc);


-- 
Best regards,
Dmitry Adamushko

