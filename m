Message-ID: <4B968538.7030204@domain.hid>
Date: Tue, 09 Mar 2010 18:28:24 +0100
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] COMEDI vs Analogy
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello. Now that i have most of my data acquisition application
infrastructure mostly working it is time to get real data.

In my non-RT code I successfully use Comedi drivers and I saw some work
for make those work over RTDM. However in the latest source tree I see
only references to the newer Analogy drivers.

It looks like Analogy is the evolution of Comedi+RTDM, however it
supports a mush smaller range of devices. There is still a way to use
Comedi with RTDM or Analogy is the only way forward?

Comedi is now included into the staging kernel drivers. There is any
plan to merge the Analogy and Comedi efforts? It would be unfortunate to
end up with two independent sets of drivers and user land libraries.

Thanks. Cheers,
-- 
Daniele


