From: =?iso-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Date: Wed, 9 Jun 2004 14:07:59 +0200
Message-ID: <MFEEKLLJKGMFGPMHBDPEEEGCCJAA.iggarpe@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: <1085430680.3905.25.camel@domain.hid>
Subject: [Adeos-main] missing EXPORT_SYMBOL for rtf_named_create
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
To: rpm@xenomai.org, rtai@domain.hid
Cc: adeos-main@gna.org

Hi,

I'm using 3.0r4 and just noticed this line is missing in
rtai-core/ipc/fifos/fifos.c

EXPORT_SYMBOL(rtf_named_create);



Regards.

Nacho.


