Subject: Re: Analogy usage
References: <b6b70b3ef32940ac783748d10d5a91b2@rtxi.org>
 <591b95a6-d81e-0f87-5d36-1af5d05e0688@siemens.com>
 <4eb17090-1b81-dfd5-b384-6374efd751b4@akamina.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e2b7bc9b-f6d9-6503-66a5-34792e2f01d8@siemens.com>
Date: Wed, 28 Jul 2021 08:11:37 +0200
MIME-Version: 1.0
In-Reply-To: <4eb17090-1b81-dfd5-b384-6374efd751b4@akamina.com>
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
To: Peter Laurich <Peter.Laurich@akamina.com>, ivan@rtxi.org, xenomai@xenomai.org

On 27.07.21 15:08, Peter Laurich wrote:
> Good morning,
> 
> We do indeed use Analogy for both data acquisition and control. In the
> past, our hardware platforms tended to be x86-based hardware with some
> lower-cost analogue input hardware built into the base such as the
> Diamond Neptune. Since this platform is EOL, we have moved to lower cost
> ARM platforms with a mPCIe interface. Most recently, we added support
> for the ACCES I/O mPCIe-AIO16 8DI/16SE analog input channels. We are
> using the Cannon Automata K1 right now and have used the Cannon Automata
> A2 in the past. For the A2, we developed an Analogy driver which gave us
> access to digital I/O, the CAN Bus as well as the real-time SERCOS III
> communications channel for synchronous motor control. We have a K1
> Analogy driver module that gives us access to digital I/O and CAN Bus
> I/O. I expect that we will look at extending the K1 Analogy driver to
> give us access to the SERCOS communications channel as well. For CAN Bus
> and digital I/O, we considered using existing drivers for CAN Bus I/O
> and GPIO but elected to stick with the Analogy interface instead.
> 
> We have also implemented a small number of the Analogy API calls on a
> Windows system so that we could use our higher level code (which calls
> Analogy functions) yet still use NI's acquisition hardware and Windows
> driver code. This worked quite well for input and buffered output since
> the NI code and hardware could fill or empty data buffers in real time
> and all of our code had to do was manage the buffers quickly enough;
> this would not have worked for control where each tick must be managed
> in real time.
> 
> In short, we have embraced Analogy for our drivers and the user-space
> threads that access the drivers.
> 
> I certainly miss the support for sharing events between kernel modules
> (Analogy drivers) and user-space threads as well as the ability to
> exchanges messages between user-space and kernel-space with Xenomai
> support. I used these capabilities extensively with Xenomai 2.6 and will
> need to find a way to replace the lost direct support for these in
> Xenomai 3.1.

Work upstream, that's all advice I can give you. You hopefully see now
what happens when working in the shadow.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

