Message-ID: <4795E0E3.20906@domain.hid>
Date: Tue, 22 Jan 2008 13:26:11 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4e0b9cb00801220251v6506ed7eq962ccedf617f9bba@domain.hid>
In-Reply-To: <4e0b9cb00801220251v6506ed7eq962ccedf617f9bba@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] Proprietary RTOS on top of Adeos
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Remi Lefevre <rlefevre@domain.hid>
Cc: adeos-main@gna.org

Remi Lefevre wrote:
> Hello,
> 
> At first, congratulations for this very interesting project.
> 
> I have a simple question : does the Adeos licence and integration with
> Linux allows to port a proprietary RTOS on top of Adeos without
> setting it in GPL (as a whole or as a skin) ?
> I'm conscious this is not the aim of this project, but convincing
> company politics may take some time...
>

Neither Adeos or any kernel-based part of Xenomai were meant, are
currently meant or will ever be meant to be "GPL barriers".
Additionally, we do use and depend on Linux kernel code, including
fairly internal one, and as such we do fully comply with the kernel license.

-- 
Philippe.

