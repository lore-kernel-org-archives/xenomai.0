Subject: Re: [Adeos-main] CVS checkout does not include new patches
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <40BF5148.8000104@domain.hid>
References: <40BF5148.8000104@domain.hid>
Content-Type: text/plain
Message-Id: <1086194508.730.28.camel@domain.hid>
Mime-Version: 1.0
Date: Wed, 02 Jun 2004 18:41:48 +0200
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

On Thu, 2004-06-03 at 18:26, Wolfgang Grandegger wrote:
> Hello,
> 
> when I checkout the ADEOS tree as describe on the GNA project pages I
> get rather old files e.g. the latest rc12 and rc13c patches are missing
> (which I see through the CVS web interface). Am I doing something wrong?
> 

It's just that the adeos/adeos directory which you seem to look at is in
fact the old one as imported from savannah. In fact, it should have been
renamed adeos/archives (I still need to fill a support request to the
GNA people to have this done). All patches should be available in
adeos/patches, all individual files under adeos/linux and so on.

> Thanks.
> 
> Wolfgang.
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
-- 

Philippe.


