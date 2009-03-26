Message-ID: <49CBFA89.8020500@domain.hid>
Date: Thu, 26 Mar 2009 22:58:33 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <49CBB6C5.5000407@domain.hid> <49CBBD4B.7070800@domain.hid>
	<49CBEDE2.5040106@domain.hid> <49CBF29D.5020500@domain.hid>
	<49CBF91A.1070201@domain.hid>
In-Reply-To: <49CBF91A.1070201@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Keyboard IRQ
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Antoine Nourry <nourry@domain.hid>
Cc: xenomai@xenomai.org

Antoine Nourry wrote:

> I neither understand, is there a way to measure precisely the absolute 
> time of a keypress event on our computers ?

Well, you can wait for the event in a user-space program, and use Linux
plain gettimeofday. It will probably give you more than enough precision.

-- 
					    Gilles.

