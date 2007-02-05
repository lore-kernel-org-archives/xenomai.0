Message-ID: <b647ffbd0702050801y60c76db3scb63a0290350b3b4@domain.hid>
Date: Mon, 5 Feb 2007 17:01:49 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] C-API to access task runtime statistic?
In-Reply-To: <2533584.1170689689401.JavaMail.ngmail@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2533584.1170689689401.JavaMail.ngmail@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

> is there a C-API in Xenomai that allows to retrieve the runtime statistic from user space?
> My realtime application has a background task that has to provide such information
> to the user.
> Of course I can get the information by parsing the /proc/xenomai/stat file.
> However, as my application is written in C, a direct access of the runtime information
> is actually more straightforward...

/proc/.. is already a generic interface to the user space. I don't see
how 2  interfaces could be more straightforward.

The only justification - I'd think of at the moment - would be a
requirement to have an interface from the real-time domain.

At least for the "native" skin, there are functions like
rt_object_inquire() to provide some info about a given object. Indeed,
rt_task_inquire() could be easily extended to return related
statistics counters as an additional bonus (although, one should have
an object's descriptor).

Otherwise, linux standard utilities like ps, top, ... retireve
information from /proc as well.



-- 
Best regards,
Dmitry Adamushko

