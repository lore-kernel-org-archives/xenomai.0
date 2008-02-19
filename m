MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18363.24363.926803.782361@domain.hid>
Date: Tue, 19 Feb 2008 23:58:51 +0100
In-Reply-To: <3453.62.39.72.60.1203416373.squirrel@domain.hid>
References: <15295.81.252.86.91.1203350819.squirrel@domain.hid>
	<2ff1a98a0802180813t5e2dcd98sc0af6db3f8f3439a@domain.hid>
	<3453.62.39.72.60.1203416373.squirrel@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Problem of thread creation with Xenomai Posix 2
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fabien MAHOT <fabien.mahot@domain.hid>
Cc: xenomai@xenomai.org

Fabien MAHOT wrote:
 > > On Mon, Feb 18, 2008 at 5:06 PM, Fabien MAHOT
 > > <fabien.mahot@domain.hid> wrote:
 > >> Xenomai 2.3.4
 > >
 > > When you reply a mail, please hit the "reply" button, so that the mail
 > > gets properly threaded by mail clients and by the mailing list
 > > archives.
 > >
 > > Now, about your issue, I suspect what you observe is a consequence of
 > > pthread_create behaviour, could you try applying the patch I sent, or
 > > use Xenomai development trunk or v2.4.x branch ?
 > >
 > > --
 > >  Gilles Chanteperdrix
 > >
 > 
 > Ok, I didn't want to use your patch because I would like to have a
 > standard solution... I think I will try with Xenomai 2.4.x
 > 
 > Thank you for your answer

I should have said the "reply all" button instead of simply "reply" ;-)

I can reproduce the issue you have if I disable the "priority coupling"
option in kernel configuration menu. With this option enabled, the
scheduler works as you expect, even without the latest posix skin fixes.

For more information on priority coupling, read the help in kernel
configuration menu.

-- 


					    Gilles Chanteperdrix.

