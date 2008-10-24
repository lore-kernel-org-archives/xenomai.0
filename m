Message-ID: <49020997.6050106@domain.hid>
Date: Fri, 24 Oct 2008 19:44:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <258091.63324.qm@domain.hid>
	<49020943.80708@domain.hid>
In-Reply-To: <49020943.80708@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] trap exceptions in user
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gabriele Moabiti <gabmoa@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Xenomai help <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Gabriele Moabiti wrote:
>> (...)
>> I consider now ManageCustomExceptions a function that do nothing.
>> (...)
>> INT 0 (divide error) or 16 (fpu exception)
>> The system hangs.
> 
> It will not work. It is because you have to handle the exception.
> Otherwise, when returning to user-space, your programs tries the faulty
> exception again, triggers the handler, which does nothing, and loops

I meant try the faulty *instruction* again

> indefinitely...
> 


-- 
					    Gilles.

