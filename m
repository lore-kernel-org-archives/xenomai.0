Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <4B464973.5050608@domain.hid>
Date: Thu, 07 Jan 2010 21:52:03 +0100
From: Alexis Berlemont <berlemont.hauw@domain.hid>
MIME-Version: 1.0
References: <4B4632D1.3020709@domain.hid>
In-Reply-To: <4B4632D1.3020709@domain.hid>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Sensoray 526 analogy driver
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Alessio Margan @ IIT" <alessio.margan@domain.hid>
Cc: Xenomai-core@domain.hid

Hi,

Alessio Margan @ IIT wrote:
> Hi,
> 
> I've got a doubt about s526 driver on reading analog input.
> 
> I read analog data in this way
> 
> sampl_t data;
> a4l_insn_t insn_tab = {
> .type = A4L_INSN_READ,
> .idx_subd = idx_subd,
> .chan_desc = CHAN(idx_chan),
> .data_size = sizeof(data),
> .data = &data};
> 
> /* Sends the read instruction to the Analogy layer */
> ret = a4l_snd_insn(&dsc, &insn_tab);
> 
> on driver side data_size is the number of samples not the nr of byte to 
> read,
> the driver expect data_size to be the number of samples and data to be a 
> vector of samples
You are right. There is a bug in the driver. The field data_size is not 
the acquisition count but the size of all the acquisitions in bytes.

So we should see:
for (n = 0; n < insn->data_size / sizeof(uint16_t); n++) {

I will fix it tonight.

> 
> uint16_t *data = (uint16_t *)insn->data;
> 
> /* convert n samples */
> for (n = 0; n < insn->data_size; n++) {
> /* trigger conversion */
> outw(value, ADDR_REG(REG_ADC));
> a4l_info(dev, "s526_ai_rinsn: Wrote 0x%04x to ADC\n", value);
> a4l_info(dev, "s526_ai_rinsn: ADC reg=0x%04x\n", inw(ADDR_REG(REG_ADC)));
> 
> #define TIMEOUT 100
> 
> /* wait for conversion to end */
> for (i = 0; i < TIMEOUT; i++) {
> status = inw(ADDR_REG(REG_ISR));
> if (status & ISR_ADC_DONE) {
> outw(ISR_ADC_DONE, ADDR_REG(REG_ISR));
> break;
> }
> }
> if (i == TIMEOUT) {
> a4l_warn(dev, "s526_ai_rinsn: ADC(0x%04x) timeout\n", 
> inw(ADDR_REG(REG_ISR)));
> return -ETIMEDOUT;
> }
> 
> /* read data */
> d = inw(ADDR_REG(REG_ADD));
> a4l_info(dev, "s526_ai_rinsn: AI[%d]=0x%04x\n", n, (unsigned short)(d & 
> 0xFFFF));
> 
> /* munge data */
> data[n] = d ^ 0x8000;
> }
> 
> TIA
> 
> Alessio
> 

Alexis.

