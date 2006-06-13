Message-ID: <47514.155.98.4.39.1150228411.squirrel@domain.hid>
In-Reply-To: <448EEF9D.30208@domain.hid>
References: <45045.155.98.4.39.1150149018.squirrel@domain.hid> 
	<448E5A2B.9060606@domain.hid>      
	<3384.206.81.135.88.1150211884.squirrel@domain.hid>      
	<448EDECA.7030302@domain.hid>   
	<36429.155.98.4.39.1150216385.squirrel@domain.hid>   
	<448EE9C3.4060706@domain.hid>
	<40729.155.98.4.39.1150217383.squirrel@domain.hid>
	<448EEF9D.30208@domain.hid>
Date: Tue, 13 Jun 2006 13:53:31 -0600 (MDT)
Subject: Re: [Xenomai-help] strange periodic behavior
From: "Brandt Erickson" <brandt@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

Turns out the timestamp was calculated using rt_timer_tsc() so on a
machine with a processor speed close to 1GHz the value is close to the
wall clock time but on a 2.2GHz machine the value is off.  Using
rt_timer_tsc2ns() solves the issue.  Thanks for the help.
-Brandt


