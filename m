Message-ID: <40BF540B.9010303@domain.hid>
Date: Thu, 03 Jun 2004 18:38:35 +0200
From: Wolfgang Grandegger <wolfgang.grandegger@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] CVS checkout does not include new patches
References: <40BF5148.8000104@domain.hid>
In-Reply-To: <40BF5148.8000104@domain.hid>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Wolfgang Grandegger <wolfgang.grandegger@domain.hid>
Cc: adeos-main@gna.org

On 06/03/2004 06:26 PM Wolfgang Grandegger wrote:
> Hello,
> 
> when I checkout the ADEOS tree as describe on the GNA project pages I
> get rather old files e.g. the latest rc12 and rc13c patches are missing
> (which I see through the CVS web interface). Am I doing something wrong?

Argh, I found the problem. I actually have done a

 $ cvs -d ... co adeos

which does not contain the most up-to-date stuff. Instead I should do:

 $ cvs -d ... co patches
 $ cvs -d ... co linux
 ...

Is this by purpose?

Thanks.

Wolfgang.

