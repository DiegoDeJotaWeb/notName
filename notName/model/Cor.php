<?php 

class Cor{
	private $idCor;
	private $descCor;
	private $hexCor;

    public function getIdCor()
    {
        return $this->idCor;
    }

    public function getDescCor()
    {
        return $this->descCor;
    }

    public function getHexCor()
    {
        return $this->hexCor;
    }

    public function setIdCor($idCor)
    {
        $this->idCor = $idCor;
    }

    public function setDescCor($descCor)
    {
        $this->descCor = $descCor;
    }

    public function setHexCor($hexCor)
    {
        $this->hexCor = $hexCor;
    }

	
}


 ?>