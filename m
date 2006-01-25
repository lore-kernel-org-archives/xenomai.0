From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-help] RTDM and possible bug
Date: Wed, 25 Jan 2006 10:08:32 -0200
References: <200601242019.05696.lbocseg@domain.hid> <43D6D745.3070701@domain.hid>
In-Reply-To: <43D6D745.3070701@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200601251008.32240.lbocseg@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

>Rodrigo Rosenfeld Rosas wrote:
>> Hi Jan,
>>
>> I'm getting the following message from kernel:
>> Xenomai: RTDM: no non-RT close handler
>> Error registering RTDM device
>>
>> But I am using only a RT open handler and a RT close handler. The
>> documentation states:
>> "rtdm_close_handler_t 	close_nrt
>>  	Close handler for non-real-time contexts, optional if close_rt is
>> non-NULL." which is my case.
>>
>> Am I missing something?
>
>Nope, it's bug in the documentation. Do you actually depend on RT
>context for cleanup?
For now, I can't think a reason I would need RT context for cleaning up.=20
Actually, I do nothing for now on cleanup.

>I recently decided to enforce a non-RT closure handler on registration.
>This is required to be able to do the
>
>    echo file_descriptor > /proc/xenomai/rtdm/open_fildes
>
>dance on forgotten file descriptors and to implement on day an automatic
>closure on process termination.
>
>The doc is now fixed, thanks for reporting.

Ok, I'll add a non-RT close handler to my driver.

Thanks,

Rodrigo.

=09

=09
	=09
_______________________________________________________=20
Yahoo! doce lar. Fa=E7a do Yahoo! sua homepage.=20
http://br.yahoo.com/homepageset.html=20



