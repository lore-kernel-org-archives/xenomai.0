From: Marco Jackel <ich@domain.hid>
Date: Tue, 16 May 2006 10:43:43 +0200
Message-ID: <e4c3bv$829$1@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: news <news@domain.hid>
Subject: [Xenomai-help] [RTDM] best strategy for periodic reading 
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

Hello,
I'm writing a driver for a A/D converter with a multiplexer. I want to 
access it with software controlled conversion. The controller has 15 
Inputs. I've to set a few Bits to select the Channel that I want to read 
from and to start the conversion. I want to access different channel 
with a different frequency. At the moment I try to do this with 
different realtime-tasks started from the "read_rt" function 
(rtdm_task_init).
Is this the best way or is there something more elegant?

Thanks
Maggo


