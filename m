Date: Wed, 29 Aug 2007 11:25:44 +0200 (CEST)
From: Herman Bruyninckx <Herman.Bruyninckx@domain.hid>
In-Reply-To: <904710.33097.qm@domain.hid>
Message-ID: <Pine.LNX.4.64.0708291123120.28485@domain.hid>
References: <904710.33097.qm@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-help] Re : sqrt() function in xenomai kernel module
Reply-To: Herman Bruyninckx <herman.bruyninckx@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mathieu JOINIE-MAURIN <mjoiniem@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 29 Aug 2007, Mathieu JOINIE-MAURIN wrote:

> The application I used is a small controller for robot developped by
> people in the lab. Before it used to be in RTAI. But now they are trying
> to use Xenomai. The application is splitted in two parts:
> the user side which saves data, manages interfaces and the kernel module
> which realise all the real time tisk (sampling, writing to electronic card,
> controler). The communications between the two is made by 5 pipes (command,
> parameters, acknowledgment, save, status).

<shameless plug>
These aspects are all covered in our Orocos project
(<http://www.orocos.org>) in which everything runs in "user space" (if you
use the Xenomai or RTAI versions.
</shameless plug>

> This is why i need to make my sqrt() function (of double variables)  into
> my kernel modul part.

I do agree very much with Jan that you should not be doing the application
logic in kernel space. There is really no need for that in 99,99% of the
applications.

Herman

Disclaimer: http://www.kuleuven.be/cwis/email_disclaimer.htm


