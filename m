Message-ID: <4D9627BC.2040705@domain.hid>
Date: Fri, 01 Apr 2011 21:30:04 +0200
From: Julien Delange <julien@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Porting comedi drivers to the analogy layer
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Dear all,

I'm currently using Xenomai with the analogy drivers for one card. It 
works perfectly and I am able to interface real-time apps with my 
national instrument card. However, the card I had until now (PCI-6071E) 
is supported by both the analogy layer of Xenomai and comedi. Now, I 
would like to use another national instrument card : the PCI-6704. 
Unfortunately, it seems not supported by the analogy layer even if the 
comedi driver supports it. So, I am wondering if porting the driver from 
comedi to the analogy layer would require a significant development 
effort and if there was similar initiative (potential port that were not 
backported to the trunk of Xenomai).

Thanks for any comment/suggestion,

Best regards,

