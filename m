Subject: Re: RTDM Kernel Driver exchanging with Linux Application via
 /dev/rtp0/ using RTIPC Protocol and XDDP socket
References: <94C4E050-9732-4A9D-B358-7F93BB36E96D.ref@yahoo.fr>
 <94C4E050-9732-4A9D-B358-7F93BB36E96D@yahoo.fr>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <010c1454-3ce4-6bca-b64d-a9797213d734@siemens.com>
Date: Tue, 5 May 2020 21:22:49 +0200
MIME-Version: 1.0
In-Reply-To: <94C4E050-9732-4A9D-B358-7F93BB36E96D@yahoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: ayaida marwane <ayaida_marwane@yahoo.fr>, xenomai@xenomai.org

On 29.04.20 23:21, ayaida marwane via Xenomai wrote:
> Dear all,
> 
> I am trying to develop a simple example of a RTDM driver running from Xenomai Kernel, that exchanges a string ("Hello world!") with a Linux Application using /dev/rtp0.
> 
> I already succeeded doing this with Xenomai 2 using RT_PIPE. However, as I understand, this using RT_PIPE from the Kernel depreciated in Xenomai 3 and it is recommended to use RTIPC Protocol and a XDDP socket.
> 
> In the documentation, there are some examples (xddp-echo.c, xddp-label.c and xddp-stream.c), that worked well in my Xenomai 3.0.7 installed on a Raspberry Pi3.
> 
> However, these examples are using a simple socket Protocol (socket(), bind(), sendto() and recvfrom()) using the POSIX Skin. So, using this in a RTDM module, will surely not work.
> 
> Therefore, as I understand, I have to use the Real-time IPC defined in the RTDM Skin  (socket__AF_RTIPC(), bind__AF_RTIPC(), sendmsg__AF_RTIPC() and recvmsg__AF_RTIPC()).
> 

These calls do not exist (where did you find them?) as your build error 
also says. Check the inter-driver API for such a stacking scenario. It 
provides rtdm_socket, rtdm_sendmsg etc.

Depending on what kind of Linux application shall use the API in the 
end, it can be simpler to compile that for Xenomai and use the RTDM 
userspace API directly to talk to the RTDM driver.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

