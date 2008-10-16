Message-ID: <20081017001047.zdrm2wdf4scsg8go@domain.hid>
Date: Fri, 17 Oct 2008 00:10:47 +0200
From: Alexis Berlemont <berlemont.hauw@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] application porting to Comedi4RTDM
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi,

Sorry for answering so late (not at home, no access to my private
mails, not even able to answer your mail properly).

Even if the Comedi API has been slightly modified, the Comedi
principles remain the same. Consequently, I think you will be able to
port your application to Comedi4RTDM.

Which kernel driver are you using for your application? The first
step would be the porting of the driver on Comedi4RTDM. I am very
interested on porting legacy Comedi drivers to the new framework;
unfortunately, I have no hardware to validate the new drivers...

Concerning the user application, maybe the best way to get familiar  
with the changes in the user API would be thanks to the doxygen  
documentation. This documentation is available in the subversion trunk  
but you will have to generate it yourself.

Regards.

Alexis.

