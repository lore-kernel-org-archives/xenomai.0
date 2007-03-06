Message-ID: <bc4264770703060737q74c7583dma99bc4f696b68e75@domain.hid>
Date: Tue, 6 Mar 2007 15:37:30 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] rtcan and secondary mode
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

Hi,

perhaps we should try and figure out where the can code goes into
secondary mode. That is the only time it can break the real-time
behavior if I understand correctly? If the call to linux space takes
too long. What calls will this be? Can we hack them out of the code?

As long as there are no incoming messages the period-times stay
stable. As soon as messages come in the real-timeliness is broken.
What operations can possibly take place on a read from the buffer ring
that let the process go into linux space?

Just a thought because I have run out of ideas as to what I can do to
my own code. :)

Regards,

Roland

