Subject: Re: [PATCH 4/6] drivers/can: add a minimal support to ethtool API
References: <20211124234648.7428-1-dariobin@libero.it>
 <20211125004644.4.Ia5c620cabdfdf1d9fb20719eddce89c52aa4af62@changeid>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <13bfd3b6-94bd-6e60-3978-4683f8aebc87@siemens.com>
Date: Thu, 25 Nov 2021 11:26:41 +0100
MIME-Version: 1.0
In-Reply-To: <20211125004644.4.Ia5c620cabdfdf1d9fb20719eddce89c52aa4af62@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Dario Binacchi <dariobin@libero.it>, xenomai@xenomai.org
Cc: Philippe Gerum <rpm@xenomai.org>, Socketcan-users@lists.berlios.de, Michael Trimarchi <michael@amarulasolutions.com>, Gianluca Falavigna <gianluca.falavigna@inwind.it>, Wolfgang Grandegger <wg@grandegger.com>, "Stephen J . Battazzo" <stephen.j.battazzo@nasa.gov>, Sebastian.Smolorz@stud.uni-hannover.de

On 25.11.21 00:46, Dario Binacchi wrote:
> Like in the Linux kernel, the API allows to get/set device controller
> parameters.
> For now it only supports:
>  - ETHTOOL_GDRVINFO: get general driver and device information
>  - ETHTOOL_GRINGPARAM: get RX/TX ring parameters
> 

What will be the use case? IIUC, only the c_can driver will implement
the required callbacks, right? Does it need this interface in order to
become operational? Is it a useful debug features? Or what is this for,
practically?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

