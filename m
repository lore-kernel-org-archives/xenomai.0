Message-ID: <2ff1a98a0802180813t5e2dcd98sc0af6db3f8f3439a@domain.hid>
Date: Mon, 18 Feb 2008 17:13:19 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <15295.81.252.86.91.1203350819.squirrel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <15295.81.252.86.91.1203350819.squirrel@domain.hid>
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

On Mon, Feb 18, 2008 at 5:06 PM, Fabien MAHOT
<fabien.mahot@domain.hid> wrote:
> Xenomai 2.3.4

When you reply a mail, please hit the "reply" button, so that the mail
gets properly threaded by mail clients and by the mailing list
archives.

Now, about your issue, I suspect what you observe is a consequence of
pthread_create behaviour, could you try applying the patch I sent, or
use Xenomai development trunk or v2.4.x branch ?

-- 
 Gilles Chanteperdrix

